require "spec_helper"

describe GithubUrl do
  subject { described_class.new(url: url) }

  describe "initialization" do
    context "when a valid url is passed with a host" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum" }

      it "instantiates itself" do
        expect { subject }.to_not raise_error
      end
    end

    context "when a valid url is passed without a protocol" do
      let(:url) { "www.github.com/gSchool/fs-curriculum" }

      it "instantiates itself" do
        expect { subject }.to_not raise_error
      end
    end

    context "given a URL with a host that is not github.com" do
      let(:url) { "http://www.google.com" }

      it "indicates that the URL does not contain github.com" do
        expect { subject }.to raise_error(described_class::Invalid, "Must contain github.com")
      end
    end

    context "given a github URL that does not include an organization" do
      let(:url) { "http://www.github.com/" }

      it "indicates that the organization is missing" do
        expect { subject }.to raise_error(described_class::Invalid, "Missing organization")
      end
    end

    context "given a github URL that does not include a repository" do
      let(:url) { "http://www.github.com/gSchool" }

      it "indicates that the repository is missing" do
        expect { subject }.to raise_error(described_class::Invalid, "Missing repository")
      end
    end

    context "when a tree key is passed without a name" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/tree" }

      it "returns the branch name given" do
        expect { subject }.to raise_error(described_class::Invalid, "Missing branch")
      end
    end

    context "when a blob key is passed without a name" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/blob" }

      it "returns the branch name given" do
        expect { subject }.to raise_error(described_class::Invalid, "Missing branch")
      end
    end

    context "when a raw key is passed without a name" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/raw" }

      it "returns the branch name given" do
        expect { subject }.to raise_error(described_class::Invalid, "Missing branch")
      end
    end
  end

  describe "#organization" do
    let(:url) { "http://www.github.com/gSchool/fs-curriculum" }

    it "returns the organization" do
      expect(subject.organization).to eq("gSchool")
    end
  end

  describe "#repository" do
    let(:url) { "http://www.github.com/gSchool/fs-curriculum" }

    it "returns the repository" do
      expect(subject.repository).to eq("fs-curriculum")
    end
  end

  describe "#branch" do
    context "when a branch name is not given" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum" }

      it "returns master" do
        expect(subject.branch).to eq("master")
      end
    end

    context "when a branch name is given" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/tree/development" }

      it "returns the branch name given" do
        expect(subject.branch).to eq("development")
      end
    end

    context "when a blob name is given" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/blob/development" }

      it "returns the branch name given" do
        expect(subject.branch).to eq("development")
      end
    end

    context "when a raw name is given" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/raw/development" }

      it "returns the branch name given" do
        expect(subject.branch).to eq("development")
      end
    end

    context "when a branch name is not in the url, and a default branch name is passed" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum" }
      let(:default_branch_name) { "development" }
      subject { described_class.new(url: url, default_branch: default_branch_name) }

      it "returns the default branch name provided" do
        expect(subject.branch).to eq(default_branch_name)
      end
    end
  end

  describe "#path" do
    context "for a master branch" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/foo/bar.md" }

      it "returns the path" do
        expect(subject.path).to eq("foo/bar.md")
      end
    end

    context "for a non-master branch" do
      let(:url) { "http://www.github.com/gSchool/fs-curriculum/tree/development/foo/bar.md" }

      it "returns the path" do
        expect(subject.path).to eq("foo/bar.md")
      end
    end
  end

  describe "host override" do
    let(:url) { "https://git.sum.enterprise.org/peterparker/web" }
    let(:host) { "git.sum.enterprise.org" }
    subject { described_class.new(url: url, host: host) }

    describe "initialization" do
      it "does not raise an error" do
        expect { subject }.to_not raise_error
      end
    end

    describe "#organization" do
      it "returns the organization" do
        expect(subject.organization).to eq("peterparker")
      end
    end

    describe "#repository" do
      it "returns the repository" do
        expect(subject.repository).to eq("web")
      end
    end

    describe "#branch" do
      it "returns the branch" do
        expect(subject.branch).to eq("master")
      end
    end

    describe "#path" do
      it "returns the path" do
        expect(subject.path).to eq("")
      end
    end
  end
end
