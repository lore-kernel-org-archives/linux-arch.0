From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: SYSV IPC broken for no-legacy syscall kernels (was Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker script)
Date: Mon, 11 Mar 2013 14:50:11 +0000
Message-ID: <201303111450.12067.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <201303111330.15589.arnd@arndb.de> <513DE0C7.9030304@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3CKOuR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2013 10:50:17 -0400
In-Reply-To: <513DE0C7.9030304@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Markos <markos.chandras@imgtec.com>

On Monday 11 March 2013, Vineet Gupta wrote:
> The question is what should the msgctl(2) ABI be w.r.t. @cmd arg. Does it need to
> be of type 0x01NN  (i.e. IPC_64 ORed) or should it be be 0xNN. If it's 0x01NN,
> then ARCH_WANT_IPC_PARSE_VERSION is needed in Kconfig, otherwise, I need to fix
> uClibc.
> 
> The reason for confusion seems to be a comment in existing uapi/linux/ipc.h which
> seems to suggest that IPC_OLD is 0 and IPC_64 is newer version.

Modern architecture ports should ignore this flag and always use the IPC_64 API,
there is no reason to maintain backwards compatibility with old binaries.

	Arnd
