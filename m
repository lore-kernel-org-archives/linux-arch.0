Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33129 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdCPJsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2017 05:48:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
References: <20170313144521.28127-1-shorne@gmail.com> <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Mar 2017 10:48:11 +0100
Message-ID: <CAK8P3a3YPsa_FXvqAmt2rQqRPc+Rby6n_+5MoMR2EV85jQHyjQ@mail.gmail.com>
Subject: Re: [PATCH v2] generic syscalls: Wire up statx syscall
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170316094811.TIJ9_acFHI8dkGDhzacpRRaAa5q56iDBJ_DpVSShge0@z>

On Wed, Mar 15, 2017 at 11:26 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 13 March 2017 at 14:45, Stafford Horne <shorne@gmail.com> wrote:

>>  #undef __NR_syscalls
>> -#define __NR_syscalls 291
>> +#define __NR_syscalls 292
>
> Out of interest, anybody know OTOH which other stat syscalls statx
> supersedes (such that they could at some point be disabled by default
> in asm-generic for new arches, and implemented in userspace)?

It should replace the entire stat family {old,new,}{f,}stat{at,}{64,}, but not
the {f,}statfs{64,} family, which will eventually get another replacement.

      Arnd
