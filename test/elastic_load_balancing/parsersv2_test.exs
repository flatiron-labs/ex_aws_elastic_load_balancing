defmodule ExAws.ElasticLoadBalancingV2.ParsersTest do
  use ExUnit.Case
  doctest ExAws.ElasticLoadBalancingV2.Parsers

  describe "describe_target_health parser" do
    test "parses DescribeTargetHealthResponse" do
      xml = """
      <DescribeTargetHealthResponse xmlns="http://elasticloadbalancing.amazonaws.com/doc/2015-12-01/">
        <DescribeTargetHealthResult>
          <TargetHealthDescriptions>
            <member>
              <HealthCheckPort>80</HealthCheckPort>
              <TargetHealth>
                <State>healthy</State>
              </TargetHealth>
              <Target>
                <Port>80</Port>
                <Id>i-0376fadf</Id>
              </Target>
            </member>
            <member>
              <HealthCheckPort>80</HealthCheckPort>
              <TargetHealth>
                <State>healthy</State>
              </TargetHealth>
              <Target>
                <AvailabilityZone>all</AvailabilityZone>
                <Port>80</Port>
                <Id>i-0376fade</Id>
              </Target>
            </member>
          </TargetHealthDescriptions>
        </DescribeTargetHealthResult>
        <ResponseMetadata>
          <RequestId>c534f810-f389-11e5-9192-3fff33344cfa</RequestId>
        </ResponseMetadata>
      </DescribeTargetHealthResponse>
      """

      expected = %{
        request_id: "c534f810-f389-11e5-9192-3fff33344cfa",
        target_health_descriptions: [
          %{
            health_check_port: "80",
            target_health: "healthy",
            targets: [%{availability_zone: "", id: "i-0376fadf", port: "80"}]
          },
          %{
            health_check_port: "80",
            target_health: "healthy",
            targets: [%{availability_zone: "all", id: "i-0376fade", port: "80"}]
          }
        ]
      }

      {:ok, %{body: body}} =
        ExAws.ElasticLoadBalancingV2.Parsers.parse(
          {:ok, %{body: xml}},
          :describe_target_health
        )

      assert expected == body
    end
  end

  describe "describe_account_limits parser" do
    test "parses DescribeAccountLimitsResponse" do
      xml = """
      <DescribeAccountLimitsResponse xmlns=\"http://elasticloadbalancing.amazonaws.com/doc/2015-12-01/\">\n  <DescribeAccountLimitsResult>\n    <Limits>\n      <member>\n        <Name>application-load-balancers</Name>\n        <Max>20</Max>\n      </member>\n      <member>\n        <Name>target-groups</Name>\n        <Max>3000</Max>\n      </member>\n      <member>\n        <Name>targets-per-application-load-balancer</Name>\n        <Max>1000</Max>\n      </member>\n      <member>\n        <Name>listeners-per-application-load-balancer</Name>\n        <Max>50</Max>\n      </member>\n      <member>\n        <Name>rules-per-application-load-balancer</Name>\n        <Max>100</Max>\n      </member>\n      <member>\n        <Name>network-load-balancers</Name>\n        <Max>20</Max>\n      </member>\n      <member>\n        <Name>targets-per-network-load-balancer</Name>\n        <Max>3000</Max>\n      </member>\n      <member>\n        <Name>targets-per-availability-zone-per-network-load-balancer</Name>\n        <Max>500</Max>\n      </member>\n      <member>\n        <Name>listeners-per-network-load-balancer</Name>\n        <Max>50</Max>\n      </member>\n    </Limits>\n  </DescribeAccountLimitsResult>\n  <ResponseMetadata>\n    <RequestId>0dcbefb0-a719-11e8-a030-d79884c70fa3</RequestId>\n  </ResponseMetadata>\n</DescribeAccountLimitsResponse>\n
      """

      expected = %{
        account_limits: [
          %{max: "20", name: "application-load-balancers"},
          %{max: "3000", name: "target-groups"},
          %{max: "1000", name: "targets-per-application-load-balancer"},
          %{max: "50", name: "listeners-per-application-load-balancer"},
          %{max: "100", name: "rules-per-application-load-balancer"},
          %{max: "20", name: "network-load-balancers"},
          %{max: "3000", name: "targets-per-network-load-balancer"},
          %{
            max: "500",
            name: "targets-per-availability-zone-per-network-load-balancer"
          },
          %{max: "50", name: "listeners-per-network-load-balancer"}
        ],
        request_id: "0dcbefb0-a719-11e8-a030-d79884c70fa3"
      }

      {:ok, %{body: body}} =
        ExAws.ElasticLoadBalancingV2.Parsers.parse(
          {:ok, %{body: xml}},
          :describe_account_limits
        )

      assert expected == body
    end
  end
end
