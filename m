From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Sat, 22 Oct 2016 17:36:34 +0200
Message-ID: <c9adb10a-1c5f-1b90-ead3-37c6665a903b@suse.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
 <7315031.MmlhY1rulM@wuerfel> <20161020145827.453025a6@roar.ozlabs.ibm.com>
 <16513464.3RM484EDf1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <16513464.3RM484EDf1@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Dne 20.10.2016 v 10:03 Arnd Bergmann napsal(a):
> On Thursday, October 20, 2016 2:58:27 PM CEST Nicholas Piggin wrote:
>>
>> Yeah, I had the same idea as you and Michal too. It's conceptually nicer,
>> but in practice it turned into a mess. If some architectures wanted to start
>> protecting their .h files and including them into .S for the prototypes, we
>> could start parsing those too. Should we do the quick and dirty way for 4.9?
> 
> Let's stay with your approach for now.

Agreed.

Michal

