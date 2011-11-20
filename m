From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH RFC 3/5] kbuild/extable: Hook up sortextable into the
 build system.
Date: Sun, 20 Nov 2011 14:45:16 +0100
Message-ID: <4EC9046C.3050708@suse.cz>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35450 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1KTNpQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Nov 2011 08:45:16 -0500
In-Reply-To: <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, x86@kernel.org, David Daney <david.daney@cavium.com>

On 18.11.2011 20:37, David Daney wrote:
> +	$(if $(CONFIG_BUILDTIME_EXTABLE_SORT),				\
> +	$(Q)$(if $($(quiet)cmd_sortextable),				\
> +	  echo '  $($(quiet)cmd_sortextable)  vmlinux' &&)		\
> +	  $(cmd_sortextable)  vmlinux)

Why do you opencode $(call cmd,sortextable) here?

Michal
