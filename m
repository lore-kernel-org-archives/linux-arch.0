Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37427 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbcKUI2A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Nov 2016 03:28:00 -0500
Date: Mon, 21 Nov 2016 09:27:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 11/20] x86: Add support for changing memory
 encryption attribute
Message-ID: <20161121082754.at6lhjhekbzjgyhc@pd.tnic>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003655.3280.57333.stgit@tlendack-t1.amdoffice.net>
 <20161117173945.gnar3arpyeeh5xm2@pd.tnic>
 <6f1a16e4-5a84-20c0-4bd3-3be5ed933800@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f1a16e4-5a84-20c0-4bd3-3be5ed933800@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161121082754.Qwa5tLTgWJ9sjoDO1_g1YVKPcX6cp75Z9GVcyO-nUw0@z>

On Sat, Nov 19, 2016 at 12:48:27PM -0600, Tom Lendacky wrote:
> Should I move this functionality into the sme_set_mem_* functions or
> remove the sme_set_mem_* functions and use the set_memory_* functions
> directly.  The latter means calculating the number of pages, but makes
> it clear that this works on a page level while the former keeps
> everything the mem_encrypt.c file (and I can change that to take in a
> page count so that it is clear about the page boundary usage).

A user of that interface doesn't care, right?

All she wants to do is pass in an address and size and the code will
figure out everything. And I think address and size is the simplest two
args you can pass. numpages can be calculated from it. As you do in
sme_set_mem_*.

And you need to do it all in pageattr.c because it uses the cpa wankery
in there so you probably want to define

int set_memory_dec(unsigned long addr, size_t size)
int set_memory_enc(unsigned long addr, size_t size)

there which both simply call

__set_memory_enc_dec(unsigned long addr, size_t size, bool enc)

and it goes and figures out everything, builds the cpa_data and does the
mapping.

That looks very simple and clean to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
