package com.liferay.commerce.demo.bulk.renderer.util;

import com.liferay.commerce.constants.CommerceWebKeys;
import com.liferay.commerce.context.CommerceContext;
import com.liferay.commerce.currency.model.CommerceMoney;
import com.liferay.commerce.discount.CommerceDiscountValue;
import com.liferay.commerce.price.CommerceProductPrice;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.util.StringPool;
import javax.portlet.PortletRequest;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Locale;

public class BulkOrderRendererHelper {

    public BulkOrderRendererHelper(PortletRequest request) {
        _commerceContext = (CommerceContext)request.getAttribute(
                CommerceWebKeys.COMMERCE_CONTEXT);
        _themeDisplay = (ThemeDisplay)request.getAttribute(
                WebKeys.THEME_DISPLAY);
    }

//    public void setPriceInfo(CommerceContext commerceContext, Locale locale)
//            throws PortalException {
//
//        _formattedPromoPrice = StringPool.BLANK;
//
//        if (_cpInstanceId <= 0) {
//            _formattedPrice = getFormattedPrice(
//                    _quantity, commerceContext, locale);
//        }
//        else {
//            CommerceProductPrice commerceProductPrice =
//                    commerceProductPriceCalculation.getCommerceProductPrice(
//                            _cpInstanceId, _quantity, commerceContext);
//
//            if (commerceProductPrice == null) {
//                return;
//            }
//
//            CommerceMoney unitPriceMoney = commerceProductPrice.getUnitPrice();
//
//            _formattedPrice = unitPriceMoney.format(locale);
//
//            _formattedPromoPrice = StringPool.BLANK;
//
//            if (_showPromo) {
//                CommerceMoney finalPriceMoney =
//                        commerceProductPrice.getFinalPrice();
//
//                BigDecimal promoPrice = finalPriceMoney.getPrice();
//
//                if (promoPrice.compareTo(unitPriceMoney.getPrice()) < 0) {
//                    _formattedPromoPrice = finalPriceMoney.format(locale);
//                }
//            }
//
//            if (_showDiscount) {
//                setDiscountInfo(commerceProductPrice);
//            }
//        }
//    }
//    protected String getFormattedPrice(
//            int quantity, CommerceContext commerceContext, Locale locale)
//            throws PortalException {
//
//        CommerceMoney minPriceCommerceMoney =
//                commerceProductPriceCalculation.getUnitMinPrice(
//                        _cpDefinitionId, quantity, commerceContext);
//
//        if (minPriceCommerceMoney == null) {
//            return StringPool.BLANK;
//        }
//
//        if (!_showPriceRange) {
//            return minPriceCommerceMoney.format(locale);
//        }
//
//        CommerceMoney maxPriceCommerceMoney =
//                commerceProductPriceCalculation.getUnitMaxPrice(
//                        _cpDefinitionId, quantity, commerceContext);
//
//        return minPriceCommerceMoney.format(locale) + " - " +
//                maxPriceCommerceMoney.format(locale);
//    }


    private CommerceContext _commerceContext;
    private CommerceDiscountValue _commerceDiscountValue;
    private long _cpDefinitionId;
    private long _cpInstanceId;
    private DecimalFormat _decimalFormat;
    private String _discountLabel;
    private boolean _displayDiscountLevels;
    private String _formattedPrice;
    private String _formattedPromoPrice;
    private String _promoPriceLabel;
    private int _quantity;
    private boolean _showDiscount = true;
    private boolean _showDiscountAmount;
    private boolean _showPercentage = true;
    private boolean _showPriceRange;
    private boolean _showPromo = true;
    private ThemeDisplay _themeDisplay;
}
