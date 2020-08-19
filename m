Return-Path: <SRS0=n/+H=B5=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79222C433E3
	for <linux-arch@archiver.kernel.org>; Wed, 19 Aug 2020 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5215A20639
	for <linux-arch@archiver.kernel.org>; Wed, 19 Aug 2020 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWTJLEFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgHSPqA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgHSPpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 11:45:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00627C061757;
        Wed, 19 Aug 2020 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sby85tADECWKuR0AV6X1Y6cFL27+oWWhcAc5MYjw2/M=; b=XWTJLEFcqr4laLVNr3nsFyNyqX
        e+SlsapfynluFr3CfcykzGtYbYd/ET2mgqoBRiOVbPUY8SD8UznsRe7aqpmT4yJa07+5QvcGTgtQs
        NjJR7HbwXfjtd/izhMgK433mSVsy/igtYk09QsTK022Hm28n/+XM2fL5PtoubxdQ40tWDVTyhIuRT
        xaethkRRZPAUxksaFJVBQU1o+nyfyuU7Yfihft4a81CRFxM7X/FIh5aq48j/BGpFRbaXHEM8n52Tl
        qJ2z2eNi0akCUR7VXHmnHWWmlPzXgusPelGvE9FjtcJuRVy7NaCzfptySDFjBm3Q4YK7AXK1R4nWU
        EDEctJUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8QHB-0002JA-TO; Wed, 19 Aug 2020 15:45:21 +0000
Date:   Wed, 19 Aug 2020 16:45:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Christoph Hewllig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Message-ID: <20200819154521.GE17456@casper.infradead.org>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
 <20200819074340.GW2674@hirez.programming.kicks-ass.net>
 <20200819084556.im5zfpm2iquzvzws@wittgenstein>
 <20200819111851.GY17456@casper.infradead.org>
 <87a6yq222c.fsf@x220.int.ebiederm.org>
 <20200819134629.mvd4nupme7q2hmtz@wittgenstein>
 <87mu2qznlv.fsf@x220.int.ebiederm.org>
 <df7f7e17a730405ea182ec778eec22e1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df7f7e17a730405ea182ec778eec22e1@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 03:41:48PM +0000, David Laight wrote:
> Does linux have an O(1) (or do I mean o(1)) pid allocator?
> Or does it have to do a linear scan to find a gap??

O(log(n)).  It uses the IDR allocator, so 'n' in this case is the
number of PIDs currently allocated, and it's log_64 rather than log_2
(which makes no difference to O() but does make a bit of a difference
to performance)
