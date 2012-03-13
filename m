From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/35] Split arch_align_stack() out from asm-generic/system.h [ver #2]
Date: Tue, 13 Mar 2012 09:11:58 +0000
Message-ID: <201203130911.59138.arnd@arndb.de>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233935.13888.29261.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120312233935.13888.29261.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 12 March 2012, David Howells wrote:
> Split arch_align_stack() out from asm-generic/system.h into its own header of
> asm-generic/exec.h as part of the asm/system.h disintegration.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
