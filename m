Return-Path: <SRS0=FX5x=B7=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA5C433E1
	for <linux-arch@archiver.kernel.org>; Fri, 21 Aug 2020 00:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671A3206FA
	for <linux-arch@archiver.kernel.org>; Fri, 21 Aug 2020 00:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdX1FPOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6xUeXyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHUAfN (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUAfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2020 20:35:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9BC061385;
        Thu, 20 Aug 2020 17:35:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597970110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBDexs66vqBYeFASer32vxMMGyHLUgHm10rev+jFjtU=;
        b=MdX1FPOyz46JiLnFQmlox6VmRXmw+sspJ063bSB7c5e1/sO3SWrMPSv5ovGRbkpbjxRdg0
        ZFgOnfi32c63fgS9NXSegLUG4UFS4VBvI8tknHXqdIEP6cGLo4AZF+m0IX//mBnpA2aOlV
        8lWGUqOtTn0tvmJcCtuUcm8wPqcQ2rC6ePZUuLCvxxVlQuGKoxZaUl2F41axoss5JHhZbZ
        LFFeuF4uqMNxmAwYMpyt5MfM5mdQe+BF5vozEjtwbgWdo0zL5ECRaaSpA9MwOCzyxxnaed
        xCiXGx8ABZkYmM9VNcpmbxFXExfWom3mtrc/xX54fZcnHPzjCklTlZf2/EXP1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597970110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBDexs66vqBYeFASer32vxMMGyHLUgHm10rev+jFjtU=;
        b=t6xUeXyfDVYrPKgzb2eGiDgeA7x4MjY0Qgb9L5OHwR/0wbs3mII0A2FdgMfbChZZbvnNnE
        TkHuI3rPECa/tcDA==
To:     Kees Cook <keescook@chromium.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to change the syscall number at entry via orig_ax
In-Reply-To: <202008201404.6A0D5736@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com> <87blj6ifo8.fsf@nanos.tec.linutronix.de> <202008201404.6A0D5736@keescook>
Date:   Fri, 21 Aug 2020 02:35:10 +0200
Message-ID: <87364gj0ox.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 20 2020 at 14:09, Kees Cook wrote:
> On Wed, Aug 19, 2020 at 09:44:39PM +0200, Thomas Gleixner wrote:
>> My fault and I have no idead why none of the silly test cases
>> noticed. Fix below.
>
> Hmm, which were you trying? Looking just now, I see that the seccomp
> selftests were failing for all their syscall-changing tests.

/me feels stupid

It's probably all caused by the heat wave which made my brain operate
outside of the specified temperature range.

Thanks,

        tglx
