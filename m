From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] alpha: provide ioread64 and iowrite64 implementations
Date: Sat, 24 Jun 2017 11:17:42 -0600
Message-ID: <a92f7406-cce1-4b3f-c146-d04d3aa867ca@deltatee.com>
References: <20170624115707.30095-1-horia.geanta@nxp.com>
 <20170624151308.6348-1-rth@twiddle.net>
 <dfc70cc1-09a9-f6d0-83a8-c8ca5d7a232b@deltatee.com>
 <787b4be1-ce9e-6838-27b6-0cd9f8d7805f@twiddle.net>
 <721fd59b-b807-86bf-a39c-bab0b33c57c0@deltatee.com>
 <a4ecb85e-f9f7-956f-ec9e-4959313a27d8@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <a4ecb85e-f9f7-956f-ec9e-4959313a27d8@twiddle.net>
Sender: linux-alpha-owner@vger.kernel.org
To: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
List-Id: linux-arch.vger.kernel.org



On 24/06/17 10:14 AM, Richard Henderson wrote:
> So you would prefer a function containing BUG?

Don't be so obtuse. Of course not.

> Because I have to have *something* to put into the machvec function
> pointer.

Well I can't say I understand the point of the machvec code, but if
you're saying it's impossible to have the Jensen sub-arch not supply a
64bit io functions then, fine, leave it as is.

Logan
