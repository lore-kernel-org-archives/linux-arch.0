Return-Path: <SRS0=aU4y=DT=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F136C433DF
	for <linux-arch@archiver.kernel.org>; Mon, 12 Oct 2020 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F5C206CB
	for <linux-arch@archiver.kernel.org>; Mon, 12 Oct 2020 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602519899;
	bh=uMMG3LvEysFyH0Ah7g9J2BzqOdRLtc2SvliE9rvrpLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QpPYCuXxjbJE/J35KWh16TmxehesYg7NvtwZtigGFy44oq01VHrHia6ytdk61wPQU
	 bC8hg4J7M+swVkxgfikT3EsMwJY1SWe6u/m/KOaGRBvAnb1ZSFz7TysQaK4rdOD0Dw
	 P9xlblYl2k9HnoHv8QaYN9dTNd9niqE7rvIhH5uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbgJLQY6 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390442AbgJLQY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 12:24:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B795C0613D0;
        Mon, 12 Oct 2020 09:24:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so17641033edj.8;
        Mon, 12 Oct 2020 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=db+MN93y7AjKLb4W5QLwwm2ia6SOUcHK2GfcMKzg77w=;
        b=JTbXtZ7UggRoO1MeEef8XhlEz/pxwdYOZUPmHaVaMuFpskT5rI6l/9hb4pljm0aIuV
         16KzsR1QnfHHB3LruTIXkaeXCVK+tR19j0R1r7JT+eorY/heEBVAji63zxXc6PBGWI0y
         RiKrK/YyBn3E48H7ftYBKhC/CfkV3LQqMI/0tgUxptHWrfzGgly1amACIdTIfNZVVAY2
         Kv71fidvpw3pfFtT3ZLZLJPFmWsIuOi3oq1U8/uEb0EK9iOJq4fJuH7HomgFWUlpgJ/R
         UrieUW+jMUQypDUgERX5kV1afjbSvKUaAZ8ihRJLTOMBnujMxMhJrNdVxQTrv7TvIap8
         0EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=db+MN93y7AjKLb4W5QLwwm2ia6SOUcHK2GfcMKzg77w=;
        b=hHOW2OjY8s8iNXKOO9BSzK77szfrVXCllCqAKVxomzlZhN/TgIS34F3VSrxs3qiJpF
         XxHrIJXyrHoR7vQ824Vc/gWjy0bq/2z0Ar02FujBDj1wuSYtLlzIRxsF/nvxxfxRk37b
         2ExLxwz/FjyUfl5aLK/2OBs7Rbt9B865IxFzEolNT+8GmzH34GAUxuR0X2idvQuOyrzV
         Q+8YYhMKzGQBxJSnJpPLVpBZPTApcChC0z8+o+gw+pPXY1ihJf++fS5rvwiVHLcUXOzE
         QfD3qa/s/vLtrjrmP67cn/VlxG/RHESAVrc9wJS3CRmXe0Eq5NcZePCsAEA6UN7rgZHM
         N5XQ==
X-Gm-Message-State: AOAM530lyjupONFouMQ8oqDBxgNXyNfQDbjkOgxj2d+cDJn5c9SWnTHt
        hmBcbnfweRCOe9v3kznKPa0=
X-Google-Smtp-Source: ABdhPJzeha9+O39O882oND/gg3o528N1t9ZeiJpW1cwDhhsuCXPvn/BSrtcnXPXUrvmg8e19iQ7Oyw==
X-Received: by 2002:aa7:c054:: with SMTP id k20mr15356354edo.224.1602519897057;
        Mon, 12 Oct 2020 09:24:57 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id b1sm10797620edr.51.2020.10.12.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:24:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 18:24:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 17/21] llist: Add nonatomic __llist_add() and
 __llist_dell_all()
Message-ID: <20201012162454.GA3687261@gmail.com>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <159870619318.1229682.13027387548510028721.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159870619318.1229682.13027387548510028721.stgit@devnote2>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Because you are forwarding this patch here, I've added your SOB:

  Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

(Let me know if that's not OK.)

Thanks,

	Ingo
