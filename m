Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33021 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbbLKUQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2015 15:16:20 -0500
Received: by obbsd4 with SMTP id sd4so41854373obb.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2015 12:16:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56622401.20001@sr71.net>
References: <20151204011424.8A36E365@viggo.jf.intel.com> <CALCETrXwVb99hAvqR2o54aPwtpr8oubROtiRt45SiYRfUTAxCw@mail.gmail.com>
 <56622401.20001@sr71.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 11 Dec 2015 12:16:00 -0800
Message-ID: <CALCETrXxe0cWXz9TG__Ju8hFXg0X9gKfBjU_GvFK3DWTW6AL0w@mail.gmail.com>
Subject: Re: [PATCH 00/34] x86: Memory Protection Keys (v5)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, X86 ML <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Message-ID: <20151211201600.LRFjnbblTQgiKD-nNNLFTNnRHk37Y8A4bukYKWpdklM@z>

On Fri, Dec 4, 2015 at 3:38 PM, Dave Hansen <dave@sr71.net> wrote:
> On 12/04/2015 03:31 PM, Andy Lutomirski wrote:
>> On Thu, Dec 3, 2015 at 5:14 PM, Dave Hansen <dave@sr71.net> wrote:
>>> Memory Protection Keys for User pages is a CPU feature which will
>>> first appear on Skylake Servers, but will also be supported on
>>> future non-server parts.  It provides a mechanism for enforcing
>>> page-based protections, but without requiring modification of the
>>> page tables when an application changes protection domains.  See
>>> the Documentation/ patch for more details.
>>
>> What, if anything, happened to the signal handling parts?
>
> Patches 12 and 13 contain most of it:
>
>         x86, pkeys: fill in pkey field in siginfo
>         signals, pkeys: notify userspace about protection key faults
>
> I decided to just not try to preserve the pkey_get/set() semantics
> across entering and returning from signals, fwiw.

Hmm.  I'll see if I can find some time this weekend to play with that
bit.  Maybe I can test by faking it and tweaking MPX instead of PKRU.

--Andy
