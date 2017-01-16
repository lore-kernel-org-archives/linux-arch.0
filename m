Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33625 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdAPMU6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2017 07:20:58 -0500
Received: by mail-lf0-f65.google.com with SMTP id x1so7050451lff.0
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2017 04:20:57 -0800 (PST)
Date: Mon, 16 Jan 2017 12:20:38 +0000
From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Message-ID: <20170116122038.GG28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org
Message-ID: <20170116122038.pwxOq-tdEmjtrTbaFKt_ayEubDzIOPgbeUFDGATfeOE@z>

On 17-01-12 11:26:07, Dave Martin wrote:
> This patch adds support for manipulating a task's vector length at
> runtime via ptrace.
> 

I hope kernel doesn't provide such interface to ptracer to change vector
length.  The vector length is sort of a read-only property of thread/process/
program to debugger, unless we really have a clear requirement to modify
vector length in debugging.  I may miss something because I haven't debug
SVE code yet.

> As a simplification, we turn the task back into an FPSIMD-only task
> when changing the vector length.  If the register data is written
> too, we then turn the task back into an SVE task, with changed
> task_struct layout for the SVE data, before the actual data writing
> is done.
> 
> Because the vector length is now variable, sve_get() now needs to
> return the real maximum for user_sve_header.max_vl, since .vl may
> be less than this (that's the whole point).
> 

-- 
Yao (齐尧)
