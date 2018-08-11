Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37450 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeHKGmv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 02:42:51 -0400
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
 <20180811024553.GF6515@ZenIV.linux.org.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
Date: Fri, 10 Aug 2018 21:10:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180811024553.GF6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811041004.rBueWTvAf6qTL_XVanyifBZ26ay0q0yEbir3xIPfbP0@z>

On 08/10/2018 07:45 PM, Al Viro wrote:
> BTW, seeing that it's your code - why was unop used in
> alpha_ni_syscall?  I don't remember the rules re pipeline
> stalls; is it that some earlier variants prefer unop to
> nop in such places?  It's not that microoptimizing that
> one makes any difference, but just out of curiosity -
> would something like
> 	lda     $0, -ENOSYS
> 	stq     $sp, 0($sp)	/* sp != 0 */
> 	ret
> do just as well there?

Oh that.  Well, unop is a "load" and pairs with everything
on all cpus, where nop is an integer and doesn't always
pair.  So I got into the habit of using unop for everything.

The extra nop was so that lda + unop // stq + ret paired up
in in two cycles as opposed to lda /stall/ stq // ret in
three cycles on ev4+ev5.  ev6 didn't care.  FWIW.


r~
