From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v8 2/8] seccomp: kill the seccomp_t typedef
Date: Mon, 20 Feb 2012 13:55:47 +1100 (EST)
Message-ID: <alpine.LRH.2.02.1202201355010.24795@tundra.namei.org>
References: <1329422549-16407-1-git-send-email-wad@chromium.org> <1329422549-16407-2-git-send-email-wad@chromium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tundra.namei.org ([65.99.196.166]:45916 "EHLO tundra.namei.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2BTC7q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Feb 2012 21:59:46 -0500
In-Reply-To: <1329422549-16407-2-git-send-email-wad@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.org, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, keescook@chromium.org

On Thu, 16 Feb 2012, Will Drewry wrote:

> Replaces the seccomp_t typedef with struct seccomp to match modern
> kernel style.
> 
> v7: struct seccomp_struct -> struct seccomp
> v6: original inclusion in this series.
> 
> Signed-off-by: Will Drewry <wad@chromium.org>

Reviewed-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
