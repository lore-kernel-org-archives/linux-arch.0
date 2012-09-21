From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] module: add finit_module syscall to asm-generic
Date: Fri, 21 Sep 2012 11:47:40 +0930
Message-ID: <87mx0knmpn.fsf@rustcorp.com.au>
References: <20120920200702.GA18807@www.outflux.net> <201209202152.38630.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209202152.38630.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 20 September 2012, Kees Cook wrote:
>> 
>> This adds the finit_module syscall to the generic syscall list.
>> 
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This depends on the finit_module patchset in Rusty's tree, based on
>> https://lkml.org/lkml/2012/9/7/559
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Please queue this along with the other patches.

OK, I'm still holding them back from linux-next due to the question of
signatures & the new syscall.  But I expect we'll resign ourselves to an
appended signature, and they'll be fine as-is.

Cheers,
Rusty.
