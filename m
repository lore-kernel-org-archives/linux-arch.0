From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/3] scripts/checksyscalls.sh: Make renameat optional
Date: Wed, 23 Apr 2014 14:15:24 +0200
Message-ID: <201404231415.24869.arnd@arndb.de>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com> <1398247687-13453-3-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398247687-13453-3-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 23 April 2014, James Hogan wrote:
> The new renameat2 syscall provides all the functionality of renameat
> with an additional flags argument, so make renameat optional so that
> future architectures can omit it without getting a warning.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> ---
> This patch doesn't affect existing architectures, so there's no harm for
> this to wait for the v3.16 merge window.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm not actually sure how we'd arrange for new architectures not
to provide renameat() when using the generic syscall ABI, but this
patch is correct anyway.

	Arnd
