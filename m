Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46325 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfC3EF3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Mar 2019 00:05:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so1900434pll.13
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2019 21:05:29 -0700 (PDT)
Date: Fri, 29 Mar 2019 21:05:27 -0700 (PDT)
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
In-Reply-To: <20190329134045.3fb2e69f@gandalf.local.home>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt@goodmis.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, akpm@linux-foundation.org, luto@amacapital.net, roland@hack.frob.com, oleg@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de, gustavo@embeddedor.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, linux@dominikbrodowski.net, luto@kernel.org, keescook@chromium.org, ebiederm@xmission.com, ldv@altlinux.org
Message-ID: <20190330040527.pwxq2YmOSP5zF8m7PJn_utYkkx5hT0PNE2Uql0WAZX8@z>

On Fri, 29 Mar 2019 10:40:45 PDT (-0700), rostedt@goodmis.org wrote:
> On Fri, 29 Mar 2019 10:24:58 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> The whole series looks fine to me.
>
> Great! I may just send a pull request to you, after some fixes (see
> below).
>
>>
>> I still suspect that we should just remove the syscall_set_arguments()
>> thing entirely, but even without that, the cleanup of the calling
>> convention is at least an improvement.
>
> I'll keep it around for now, but this should go as a warning to Dmitry,
> to get something using it soon, or they may be dropped.
>
> Also, Dmitry found a few bugs with the current
> syscall_set/get_arguments() on some of the archs (riscv and csky). Which
> I'll add at the front of this series and update my changes to keep the
> same logic.

Thanks.  I'm happy to have you take the RISC-V fix through your tree.

>
> Then I'll post a non RFC version.
>
> -- Steve
