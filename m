Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48592C61DD8
	for <linux-arch@archiver.kernel.org>; Sun, 15 Nov 2020 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08982244C
	for <linux-arch@archiver.kernel.org>; Sun, 15 Nov 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yY1oLsjE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ix5rQgsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKOS2j (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgKOS2j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 13:28:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD8C0613D1;
        Sun, 15 Nov 2020 10:28:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605464916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diiTcQge6ZYWsdh6vNpMyaIE9NWIZ+IjrR35WDGgnso=;
        b=yY1oLsjEmGIVGlqhgClVlbPIJ12rFgqQeU6XRkQzPGYDoaU8m9G+cK6HzKPHhdO2oKj0h0
        8v8PKWhjsQqNB8BmtWODAyxRNGXko8aBw96u9tr+GlOwvJPx5nIk9A1kbesaTr5doFGanx
        gcP5pJFUVXgb7IJ192PS1wI19XaN6twNTXcAQBLs7dMI6/mGPdpYb9t+fE9lDcIViES4FX
        E78Sc8OyMILu9QiiZmXbqCR150nGPkW/Re4+nJvuPXhoSA4m0AuKDPUm5FhggKEBst2wwo
        3D1/M5t2S+knTc/HdXbyDQ47tlbBoEaWgMeWcHEuUHzy01WUNM5hFX3u/ftSaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605464916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diiTcQge6ZYWsdh6vNpMyaIE9NWIZ+IjrR35WDGgnso=;
        b=Ix5rQgsbgT78Mdo0xV/+PaTO5QuQDm8fmzmQpNn/dcDHbbQXx03aCiGSEI9jRKHF3z72eK
        i/V+o/iciSjqtWCg==
To:     Christoph Hellwig <hch@infradead.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, kernel@collabora.com
Subject: Re: [PATCH 02/10] kernel: entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
In-Reply-To: <20201114112249.GA20070@infradead.org>
References: <20201114032917.1205658-1-krisman@collabora.com> <20201114032917.1205658-3-krisman@collabora.com> <20201114112249.GA20070@infradead.org>
Date:   Sun, 15 Nov 2020 19:28:36 +0100
Message-ID: <871rgua2zv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 14 2020 at 11:22, Christoph Hellwig wrote:
>> +#ifdef CONFIG_GENERIC_ENTRY
>> +static inline void __set_task_syscall_work(struct thread_info *ti, int flag)
>> +{
>> +	set_bit(flag, (unsigned long *)&ti->syscall_work);
>> +}
>> +static inline int __test_task_syscall_work(struct thread_info *ti, int flag)
>> +{
>> +	return test_bit(flag, (unsigned long *)&ti->syscall_work);
>> +}
>> +static inline void __clear_task_syscall_work(struct thread_info *ti, int flag)
>> +{
>> +	return clear_bit(flag, (unsigned long *)&ti->syscall_work);
>
> The casts here look bogus.

Making sure that &(unsigned long) results in a pointer to unsigned long
is indeed silly.

Thanks,

        tglx
