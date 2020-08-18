Return-Path: <SRS0=YYpG=B4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3E6C433E1
	for <linux-arch@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67AE2078D
	for <linux-arch@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgEG9rX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHRUIc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHRUIb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 16:08:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82CEC061342
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so10248548pgl.10
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=GgEG9rX0CVa7+ePbq5nMU/CNYUi+2BFK3ShbA/WmzDeaqQmywgCc13epPFdB6FGzJj
         PvUunIk9PF/5CUEYbmg6f4sOwcmkbKu9OxYlJ6LaNwke2x+fD6sLSkFRzNClnnjeBX38
         8Rgdk2DtkxLnI2lh1JKe4qna0fjXUs9peD4gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=sD2lcLwwjFpLV7v3vEKCV1RNWlM2yIfXKBKpGiGcR1FIB8y6w6oXR5BT4/33vSoy+j
         /FTbP6qFWpZTKcBtC5nsLmp0RTCtXelqo53y9yeZPRr40bGGGh6W8eqUSI7i56AMF+XA
         qvZXJPnyPL/QeXTkacJCDcYwhpEGutWbGAbf/msFPlG1rAjJh0K05O/agF+A0vQiw2lY
         7Bc9SYQ9NFCPs/SPjhtcyNKrZjvM0Q2OLUo+aD71WWLfwwxZn1BODPdc4P8K+FLLmUc6
         UKupAatRrsxzTTUuWwxUKY4pX7ADVPNr+IkCt6bvlitHbgeefpD1w8tCNdgG541S0tpC
         peFQ==
X-Gm-Message-State: AOAM531oXqpF6jxXTcX2hu1deQH4oQ2G6+cITkknw964TpXCiYhgrXnu
        oGd2uruqAZkRcyhqB/hdXFVsYQ==
X-Google-Smtp-Source: ABdhPJyBLGaxMiD9h5m7lNfe0Fp88P8FDv0Rv1bI+H6lZvwzTGY3m5NIOU4EVZdC+BdDYxt8ElPefQ==
X-Received: by 2002:a62:aa05:: with SMTP id e5mr16597138pff.159.1597781310313;
        Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m62sm738843pje.18.2020.08.18.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:08:29 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181308.A4A6674@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
 <202008181244.BBDA7DAB@keescook>
 <20200818195539.GB32691@lst.de>
 <202008181258.CEC4B8B3@keescook>
 <20200818200016.GA681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818200016.GA681@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 10:00:16PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:59:05PM -0700, Kees Cook wrote:
> > > I didn't see a problem bisecting, do you have something particular in
> > > mind?
> > 
> > Oh, I misunderstood this patch to be a fix for compilation. Is this just
> > a correctness fix?
> 
> It prepares for using the definition from assembly, which is done in
> the next patch.

Ah! Okay; thanks.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
