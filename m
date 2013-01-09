From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2] sysctl: Enable IA64 "ignore-unaligned-usertrap" to be used cross-arch
Date: Wed, 09 Jan 2013 13:03:42 -0800
Message-ID: <876236ul01.fsf@xmission.com>
References: <50ED7B4B.7080603@synopsys.com>
	<1357742188-8941-1-git-send-email-vgupta@synopsys.com>
	<CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
	(Tony Luck's message of "Wed, 9 Jan 2013 10:55:27 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Fenghua Yu <fenghua.yu@intel.com>, Serge Hallyn <serge.hallyn@canonical.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Tony Luck <tony.luck@gmail.com> writes:

> Ok. Queued for 3.9 merge window.  It should show up in linux-next in
> the next day or two.  We'll see if anyone complains about the name
> SYSCTL_ARCH_UNALIGN_NO_WARN (every time I touch the Kconfig
> bits it seems that there is some other, better way that we do this
> now).

The other semi-sane way I could see to do this would be to break the
code out of kernel/sysctl.c into it's own sysctl table and have the
arches that want this sysctl just register it themselves.

Shrug.  It probably isn't worth the effor right now.

Eric
