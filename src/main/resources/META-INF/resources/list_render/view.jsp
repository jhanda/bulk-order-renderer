<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);
    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
%>
<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="dataset-display-content-wrapper">
            <div class="table-style-stacked">
                <div class="table-responsive">
                    <table class="table table-autofit">
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>
                                    <p class="table-list-title">SKU</p>
                                </th>
                                <th>
                                    <p class="table-list-title">Name</p>
                                </th>
                                <th>
                                    <p class="table-list-title">Price</p>
                                </th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <%
                            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                        %>
                        <tr>
                            <%
                                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                                CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);

                                String skuValue;
                                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();

                                if (cpSkus.size() > 1){
                                    skuValue = "Multiple SKUs";
                                }else {
                                    skuValue = cpContentHelper.getDefaultCPSku(cpCatalogEntry).getSku();
                                }
                            %>

                            <td class="">
                                <commerce-ui:add-to-wish-list
                                        CPCatalogEntry="<%= cpCatalogEntry %>"
                                        large="<%= true %>"
                                />
                            </td>
                            <td class="">
                                <a href="<%= friendlyURL %>">
                                <liferay-adaptive-media:img
									class="img-fluid product-card-picture"
									fileVersion="<%= cpContentHelper.getCPDefinitionImageFileVersion(cpCatalogEntry.getCPDefinitionId(), request) %>"
								/>
								</a>
                            </td>
                            <td class=""><a href="<%= friendlyURL %>"><%= skuValue %></a></td>
                            <td class=""><a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a></td>
                            <td class="">
                                <commerce-ui:price
                                        compact="<%= true %>"
                                        CPCatalogEntry = "<%= cpCatalogEntry %>"
                                />
                            </td>
                            <c:choose>
                                <c:when test="<%= cpSku != null %>">
                                    <td>
                                        <commerce-ui:add-to-cart
                                                alignment="right"
                                                CPCatalogEntry="<%= cpCatalogEntry %>"
                                                inline="<%= true %>"
                                                namespace="<%= liferayPortletResponse.getNamespace() %>"
                                                options='<%= "[]" %>'
                                                size="sm"
                                        />
                                    </td>
                                </c:when>
                            <c:otherwise>
                                <td>
                                    <a class="commerce-button commerce-button--outline w-100" href="<%= friendlyURL %>">
                                        <liferay-ui:message key="view-all-variants" />
                                    </a>
                                </td>
                            </c:otherwise>
                        </c:choose>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="alert alert-info">
            <liferay-ui:message key="no-products-were-found" />
        </div>
    </c:otherwise>
</c:choose>