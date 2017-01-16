From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 07/10] arm64/sve: Add vector length inheritance
 control
Date: Mon, 16 Jan 2017 12:27:55 +0000
Message-ID: <20170116122755.GH28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35731 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAPM2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2017 07:28:15 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so12413589lfa.2
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2017 04:28:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org

On 17-01-12 11:26:06, Dave Martin wrote:
> Currently the vector length is inherited across both fork() and
> exec().
> 
> Inheritance across fork() is desirable both for creating a copy of
> a process (traditional fork) or creating a thread (where we want
> all threads to share the same VL by default).
> 
> Inheritance across exec() is less desirable, because of the ABI
> impact of large vector lengths on the size of the signal frame --
> when running a new binary, there is no guarantee that the new
> binary is compatible with these ABI changes.
> 
> This flag makes the vector length non-inherited by default.

Can we make vector length inherited across fork but non-inherited
across exec by default?

> Instead, the vector length is reset to a system default value,
> unless the THREAD_VL_INHERIT flag has been set for the thread.
> 
> THREAD_VL_INHERIT is currently sticky: i.e., if set, it gets
> inherited too.  This behaviour may be refined in future if it is
> not flexible enough.
> 

-- 
Yao (齐尧)
