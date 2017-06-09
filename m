Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33500 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdFIEYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 00:24:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id v104so5309881wrb.0
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2017 21:24:10 -0700 (PDT)
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
References: <20170608025831.GA43608@beast>
 <20170608065809.GC14568@infradead.org>
 <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
 <20170608200931.GC2464@linux-80c1.suse>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <cea7c45e-511a-38ce-6b70-9a3a80108414@colorfullife.com>
Date: Fri, 9 Jun 2017 06:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170608200931.GC2464@linux-80c1.suse>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>, "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170609042404.jETx7x-_6paK-dr4QWxU-yAZc7Es8dZFptyMZUw0BeU@z>

Hi Davidlohr,

On 06/08/2017 10:09 PM, Davidlohr Bueso wrote:
>
> Yes, this would be a prerequisite for ipc; which I initially thought 
> didn't
> take a performance hit.
>
Did you see a regression for ipc?

The fast paths don't use the refcount, it is only used for rare situations:
- GETALL, SETALL for large arrays
- alloc undo

--
     Manfred
