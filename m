Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60062 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964990Ab2CMJwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 05:52:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/35] Split arch_align_stack() out from asm-generic/system.h [ver #2]
Date: Tue, 13 Mar 2012 09:11:58 +0000
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233935.13888.29261.stgit@warthog.procyon.org.uk>
In-Reply-To: <20120312233935.13888.29261.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201203130911.59138.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120313091158.qIGs1pW7Y41EJWMYfvaDra7Mjsn1kHJFmPbEHU3okvQ@z>

On Monday 12 March 2012, David Howells wrote:
> Split arch_align_stack() out from asm-generic/system.h into its own header of
> asm-generic/exec.h as part of the asm/system.h disintegration.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

