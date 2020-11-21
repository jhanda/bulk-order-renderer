<%@ page import="com.liferay.commerce.product.util.CPInstanceHelper" %>
<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPInstanceHelper cpInstanceHelper = (CPInstanceHelper)request.getAttribute("cpInstanceHelper");
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
    CommerceContext commerceContext = (CommerceContext)request.getAttribute(CommerceWebKeys.COMMERCE_CONTEXT);

%>
<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="dataset-display-content-wrapper">
            <div class="table-style-stacked">
                <div class="table-responsive">
                    <table class="table table-autofit">
                        <thead>
                        <tr class="">
                            <th class="table-cell-expand-smaller">
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">SKU</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">Name</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">Price</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                            </th>
                        </tr>
                        </thead>
                        <%
                            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                        %>
                        <tr class="">
                            <%
                                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                                CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);
                                long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();
                                String skuValue;
                                long cpInstanceId = 0;


                                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();
                                String addToCartId = PortalUtil.generateRandomKey(request, "add-to-cart");

                                if (cpSkus.size() > 1){
                                    skuValue = "Multiple SKUs";
                                }else {
                                    skuValue = cpContentHelper.getDefaultCPSku(cpCatalogEntry).getSku();
                                    cpInstanceId = cpSkus.get(0).getCPInstanceId();
                                }
                                String thumbnailSrc = cpInstanceHelper.getCPInstanceThumbnailSrc(cpInstanceId);

                            %>
                            <td class=""><img src="<%= thumbnailSrc %>"></img></td>
                            <td class=""><a href="<%= friendlyURL %>"><%= skuValue %></a></td>
                            <td class=""><a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a></td>
                            <td class="">
                                <commerce-ui:price
                                        CPDefinitionId="<%= cpCatalogEntry.getCPDefinitionId() %>"
                                        CPInstanceId="<%= cpInstanceId %>"
                                />
                            </td>
                            <td>
                                <commerce-ui:add-to-cart
                                                CPInstanceId="<%= cpSku.getCPInstanceId() %>"
                                                id="<%= addToCartId %>"
                                />
                            </td>
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