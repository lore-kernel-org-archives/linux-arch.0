Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdKVISq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Nov 2017 03:18:46 -0500
Subject: Re: MPK: removing a pkey (was: pkey_free and key reuse)
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
Date: Wed, 22 Nov 2017 09:18:44 +0100
MIME-Version: 1.0
In-Reply-To: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171122081844.7fsWKIaeACunaawp2iFO4EdWpYs5P-IE3efmEJsyc3Q@z>

On 11/05/2017 11:35 AM, Florian Weimer wrote:
> I'm working on adding memory protection key support to glibc.
> 
> I don't think pkey_free, as it is implemented today, is very safe due to 
> key reuse by a subsequent pkey_alloc.  I see two problems:
> 
> (A) pkey_free allows reuse for they key while there are still mappings 
> that use it.
> 
> (B) If a key is reused, existing threads retain their access rights, 
> while there is an expectation that pkey_alloc denies access for the 
> threads except the current one.

I have a somewhat related question to API/documentation of pkeys, that
came up from a customer interested in using the feature. The man page of
mprotect/pkey_mprotect doesn't say how to remove a pkey from a set of
pages, i.e. reset it to the default 0 (or the exec-only pkey), so
initially they thought there's no way to do that.

Calling pkey_mprotect() with pkey==0 will fail with EINVAL, because 0
was not allocated by pkey_alloc(). That's fair I guess.

What seems to work to reset the pkey is either calling plain mprotect(),
or calling pkey_mprotect() with pkey == -1, as the former is just wired
to the latter.

So, is plain mprotect() the intended way to reset a pkey and should it
be explicitly documented in the man page?

And, was the pkey == -1 internal wiring supposed to be exposed to the
pkey_mprotect() signal, or should there have been a pre-check returning
EINVAL in SYSCALL_DEFINE4(pkey_mprotect), before calling
do_mprotect_pkey())? I assume it's too late to change it now anyway (or
not?), so should we also document it?

Thanks,
Vlastimil
