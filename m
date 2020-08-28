Return-Path: <SRS0=gEkT=CG=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EFC433E2
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F65120776
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 13:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHCh0HYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgH1N7d (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgH1N6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 09:58:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FEC061264;
        Fri, 28 Aug 2020 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hGq8CaOAFXxKPe7WDzEFN5Pehs2C2y/wZVImhCCsFw=; b=NHCh0HYEMyA2HIyS7y4bLZhXQH
        2RQukhb5S5+XWbYdrzZHJ7ivfevz4WKBObInOi1SRbg0xRydLAzIdXRG+jpGKV6bFA4w/5NnCx/2x
        gKVfxmeYbtiUeP2YwIPqDN6jlHPvFKgXFCrmDtcvZCFZ4XlalHDOlWrFqcuoJYs46f3p+fX/ZmBja
        gqJaS9LCmnkETXqx7RCROgEY7yDdkCfe5QY/eOjeIe7J+HOchvxsAC4PUAerGkbwkZSRwMWd+9OlJ
        FeG/jccwTljYYNekC0bvM1lPP6Q+t0/XT/uPEKVJtOu4wxqPkROq4U8ZGzRKg4hGWbNYn/QVWgRGK
        XsNNi2gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBete-0004EY-Dp; Fri, 28 Aug 2020 13:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 078493007CD;
        Fri, 28 Aug 2020 15:58:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0CB72C5FD7F8; Fri, 28 Aug 2020 15:58:24 +0200 (CEST)
Date:   Fri, 28 Aug 2020 15:58:24 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-ID: <20200828135824.GD1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.359432340@infradead.org>
 <7df0a1af432040d9908517661c32dc34@trendmicro.com>
 <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 10:51:13PM +0900, Masami Hiramatsu wrote:
 
> OK, schedule function will be the key. I guess the senario is..
> 
> 1) kretporbe replace the return address with kretprobe_trampoline on task1's kernel stack
> 2) the task1 forks task2 before returning to the kretprobe_trampoline
> 3) while copying the process with the kernel stack, task2->kretprobe_instances.first = NULL
> 4) task2 returns to the kretprobe_trampoline
> 5) Bomb!
> 
> Hmm, we need to fixup the kernel stack when copying process. 

How would that scenario have been avoided in the old code? Because there
task2 would have a different has and not have found a kretprobe_instance
either.

