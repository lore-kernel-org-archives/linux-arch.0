From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH v3 05/15] h8300: Process and signal
Date: Sun, 15 Feb 2015 20:38:25 +0100
Message-ID: <CAFLxGvxeT3uydJVXfyDX4VnsThVJ5r40osnGE1J5btLvvz9JnQ@mail.gmail.com>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
	<1423986573-2329-6-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52039 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbbBOTi0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 14:38:26 -0500
In-Reply-To: <1423986573-2329-6-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Feb 15, 2015 at 8:49 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> +       usig = current_thread_info()->exec_domain
> +               && current_thread_info()->exec_domain->signal_invmap
> +               && sig < 32
> +               ? current_thread_info()->exec_domain->signal_invmap[sig]
> +               : sig;

Does h8300 really need signal mapping?
I'm very sure you can drop this.
In fact I'm working in patch set to rip it out tree wide as we have
only a single (broken)
in-tree user.

-- 
Thanks,
//richard
