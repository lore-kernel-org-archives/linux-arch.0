From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/18] Cross-architecture definitions of relaxed MMIO
 accessors
Date: Tue, 22 Apr 2014 16:30:54 +0200
Message-ID: <20140422143053.GA16898@ravnborg.org>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
 <20140417153638.GA7317@ravnborg.org>
 <20140417154714.GD30553@arm.com>
 <20140417191555.GA11970@ravnborg.org>
 <20140422134345.GD9820@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:51185 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbaDVObC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 10:31:02 -0400
Content-Disposition: inline
In-Reply-To: <20140422134345.GD9820@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "monstr@monstr.eu" <monstr@monstr.eu>, "dhowells@redhat.com" <dhowells@redhat.com>, "broonie@linaro.org" <broonie@linaro.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "peterz@infradead.org" <peterz@infradead.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

> 
> This is because Sparc (and the other architectures I had to modify) don't
> make use of asm-generic/io.h.
Somehow I missed this.

Added to my todo list to look into sparc in this respect.
A quick lokk reveal that sparc32 can use most/all of the generic io.h

	Sam
