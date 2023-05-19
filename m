Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C36C7EE29
	for <linux-arch@archiver.kernel.org>; Fri, 19 May 2023 17:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjESRGQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 19 May 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjESRFq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 13:05:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C1E5C;
        Fri, 19 May 2023 10:05:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3FF7B7C0;
        Fri, 19 May 2023 17:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FF7B7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684515921; bh=32yUJ/Ep+SRRswkhu8CSGkcBJ2kdTHXVgiH1bkIO4qs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Sz93O2MrDkbaobmjkJ4YaHN0AUsD9dSLwiu3oH8qY4OEUKIHsY0wZxUduPTtQiDGm
         F6EjFmjz4TlLD5IYnTPhc007iYrszZr4V5JyctI/kGhBb1Pqxf37RXfMsiP2DzS6re
         Sy0+VaKsJIfemyC0l+d2yBBLQks8akk4UaK6GRUZuIQ47YAGOajWtf66psmV+IdXtc
         7az6kUp5rKGdc9B0V326bC75avIMUS4DPGYYd8QZwOL9SHfYewwv2ZVP5glXpAm/fp
         xgu5x8yS+QifekV7BKMjJt9KX5ewJhXJ/7AgXYsVCnXAUlupWqmEHvFntzHAciAEtR
         tzl6G8QjkX3dg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: Update Documentation/arm references
In-Reply-To: <20230519-tug-garbage-4fee2efc3f0a@spud>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-8-corbet@lwn.net>
 <20230519-tug-garbage-4fee2efc3f0a@spud>
Date:   Fri, 19 May 2023 11:05:20 -0600
Message-ID: <877ct4meun.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Fri, May 19, 2023 at 10:46:07AM -0600, Jonathan Corbet wrote:
>> The Arm documentation has moved to Documentation/arch/arm; update
>> references under arch/arm64 to match.
>
> This commit message seems a wee bit inaccurate ;)

Argh.  I pulled this change out into a separate patch because checkpatch
whined at me, and did it a bit too quickly, I guess...

>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,

jon
