From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date: Wed, 24 Jul 2019 23:22:14 -0400
Message-ID: <209DCEDB-98B4-4D57-8F2C-0B8F0406B5CB@lca.pw>
References: <1563993952.11067.15.camel@lca.pw>
 <1563914986-26502-1-git-send-email-cai@lca.pw>
 <31573.1563954571@warthog.procyon.org.uk>
 <14026.1564004959@warthog.procyon.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14026.1564004959@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Jakub Jelinek <jakub@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



> On Jul 24, 2019, at 5:49 PM, David Howells <dhowells@redhat.com> wrote:
> 
> Qian Cai <cai@lca.pw> wrote:
> 
>> I have GCC 8.2.1 which works fine.
> 
> But you need to check the minimum version, i.e. 4.6:
> 
> 	#if GCC_VERSION < 40600
> 

I did check gcc version 4.1.2 20080704 and it works fine.
