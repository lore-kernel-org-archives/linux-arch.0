Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:50644 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932369AbdK0R7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 12:59:18 -0500
Subject: Re: [PATCH 3/3] y2038: rusage: use __kernel_old_timeval for process
 times
References: <20171127170121.634826-1-arnd@arndb.de>
 <20171127170121.634826-3-arnd@arndb.de>
From: Paul Eggert <eggert@cs.ucla.edu>
Message-ID: <34369a6e-e0ce-fe7b-65e3-9c4a33e4789a@cs.ucla.edu>
Date: Mon, 27 Nov 2017 09:52:06 -0800
MIME-Version: 1.0
In-Reply-To: <20171127170121.634826-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org, libc-alpha@sourceware.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Albert ARIBAUD <albert.aribaud@3adev.fr>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-alpha@vger.kernel.org
Message-ID: <20171127175206.I5APkem-OX5Lv0XnBU83RP2F-hKFj4OlKurmh-yo3jo@z>

On 11/27/2017 09:00 AM, Arnd Bergmann wrote:
> b) Extend the approach taken by the x32 ABI, and use the 64-bit
>     native structure layout for rusage on all architectures with new
>     system calls that is otherwise compatible. A possible problem here
>     is that we end up with incompatible definitions of rusage between
>     /usr/include/linux/resource.h and /usr/include/bits/resource.h
>
> c) Change the definition of struct rusage to be independent of
>     time_t. This is the easiest change, as it does not involve new system
>     call entry points, but it has the risk of introducing compile-time
>     incompatibilities with user space sources that rely on the type
>     of ru_utime and ru_stime.
>
> I'm picking approch c) for its simplicity, but I'd like to hear from
> others whether they would prefer a different approach.

(c) would break programs like GNU Emacs, which copy ru_utime and 
ru_stime members into struct timeval variables.

All in all, (b) sounds like it would be better for programs using glibc, 
as it's more compatible with what POSIX apps expect. Though I'm not sure 
what problems are meant by "possible ... incompatible definitions"; 
perhaps you could elaborate.
