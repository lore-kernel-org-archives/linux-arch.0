From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Fri, 9 Jun 2017 06:24:04 +0200
Message-ID: <cea7c45e-511a-38ce-6b70-9a3a80108414@colorfullife.com>
References: <20170608025831.GA43608@beast>
 <20170608065809.GC14568@infradead.org>
 <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
 <20170608200931.GC2464@linux-80c1.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608200931.GC2464@linux-80c1.suse>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>, "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@>
List-Id: linux-arch.vger.kernel.org

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
