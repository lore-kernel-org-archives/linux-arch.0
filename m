Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:24763 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932471AbWH1JZv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 05:25:51 -0400
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 4/7] Remove the use of _syscallX macros in UML
References: <20060827214734.252316000@klappe.arndb.de>
	<20060827215636.797086000@klappe.arndb.de>
Date: Mon, 28 Aug 2006 11:25:40 +0200
In-Reply-To: <20060827215636.797086000@klappe.arndb.de> (Arnd Bergmann's
	message of "Sun, 27 Aug 2006 23:47:38 +0200")
Message-ID: <jey7t9gqjv.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

>  int switcheroo(int fd, int prot, void *from, void *to, int size)
>  {
> -	if(munmap(to, size) < 0){
> +	if (syscall(munmap, to, size) < 0){

s/unmap/__NR_unmap/

>  		return(-1);
>  	}
> -	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
> +	if (syscall(mmap, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){

s/mmap/__NR_mmap/

>  		return(-1);
>  	}
> -	if(munmap(from, size) < 0){
> +	if (syscall(munmap, from, size) < 0){

s/unmap/__NR_unmap/

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
