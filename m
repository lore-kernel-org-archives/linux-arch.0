Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848A2EB64DD
	for <linux-arch@archiver.kernel.org>; Wed, 14 Jun 2023 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjFNHP3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 14 Jun 2023 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbjFNHPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 03:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE61BDA;
        Wed, 14 Jun 2023 00:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AD762FA9;
        Wed, 14 Jun 2023 07:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7B5C433C0;
        Wed, 14 Jun 2023 07:15:01 +0000 (UTC)
Date:   Wed, 14 Jun 2023 08:14:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: fix dangling Documentation/arm64
 reference
Message-ID: <ZIlo8xW5HP3u2Sca@arm.com>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-3-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094606.334687-3-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 13, 2023 at 03:46:03AM -0600, Jonathan Corbet wrote:
> The arm64 documentation has move under Documentation/arch/ fix a reference
> to match.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
