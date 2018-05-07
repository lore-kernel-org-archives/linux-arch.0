Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeEGJno (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 May 2018 05:43:44 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <20180502211254.GA5863@ram.oc3035372033.ibm.com>
 <CALCETrUfO=vXg5rT-n=y8pLktcq5+ORvgpsOXCHG4GaugB3k2A@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c0288ca0-4f8f-9a38-550f-f6bbfb5a91cf@redhat.com>
Date: Mon, 7 May 2018 11:43:40 +0200
MIME-Version: 1.0
In-Reply-To: <CALCETrUfO=vXg5rT-n=y8pLktcq5+ORvgpsOXCHG4GaugB3k2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, linuxram@us.ibm.com
Cc: Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>

On 05/02/2018 11:18 PM, Andy Lutomirski wrote:
> I don't know about POWER's ISA, but this is crappy behavior.  If a thread
> temporarily grants itself access to a restrictive memory key and then gets
> a signal, the signal handler should*not*  have access to that key.

Sorry, that totally depends on what the signal handler does, especially 
for synchronously delivered signals.

Thanks,
Florian
