require 'spec_helper'

describe 'cloudwatch' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "cloudwatch class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('cloudwatch::params') }
          it { is_expected.to contain_class('cloudwatch::install')
          it { is_expected.to contain_class('cloudwatch::config') }
          it { is_expected.to contain_class('cloudwatch::service')

          it { is_expected.to contain_service('awslogs').with_ensure('running') }
        end
      end
    end
  end
end
