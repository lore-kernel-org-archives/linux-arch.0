From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 00/17] Re-introduce h8300 architecture
Date: Wed, 29 Apr 2015 06:24:41 -0700
Message-ID: <5540DB99.1070800@roeck-us.net>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>	<20150428132210.GA7499@roeck-us.net>	<87pp6oi2qy.wl-ysato@users.sourceforge.jp>	<55405F08.7020508@roeck-us.net> <87lhhbihcf.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lhhbihcf.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 04/28/2015 11:22 PM, Yoshinori Sato wrote:

>
> OK.
> I made h8300-*-linux target patch for release version.
> Please apply and rebuild to "h8300-unknown-linux"
> http://sourceforge.jp/projects/uclinux-h8/releases/p14625
>
The binutils patch is similar to the one upstream, but I think
you might want to check if the latest upstream code is still
working as intended. The patch was later augmented with
'Fix recent h8300 configury changes' which, among other changes,
removed the GENSCRIPTS lines.

Thanks,
Guenter
