Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14367 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2CNPRy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Mar 2012 11:17:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1331736182.5104.74.camel@jerome.southpole.se>
References: <1331736182.5104.74.camel@jerome.southpole.se> <CACM3HyHaFqVBaALMNB9dTE+7JrT1qD0jrYtV2PzwTskv8sW4Hg@mail.gmail.com> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233858.13888.34822.stgit@warthog.procyon.org.uk> <201203130900.41993.arnd@arndb.de> <11556.1331723400@redhat.com> 
Subject: Re: [ORLinux] [PATCH 17/35] Make asm-generic/cmpxchg.h #include asm-generic/cmpxchg-local.h [ver #2]
Date: Wed, 14 Mar 2012 15:17:38 +0000
Message-ID: <18016.1331738258@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux@openrisc.net, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org
Message-ID: <20120314151738.sjfzw9uCvZDn_oWWr3F0gVEEZmqaenBY2y9lerSrBn0@z>

Jonas Bonn <jonas@southpole.se> wrote:

> Am I right in thinking that OpenRISC is the only architecture the
> depends on the changes in asm-generic?

I'm not sure.  I think c6x does too to some extent.

> The error I get while building (if asm/system.h is included) is a
> circular dependency that I don't see that I can easily resolve:

How do I get an openrisc toolchain?

David
