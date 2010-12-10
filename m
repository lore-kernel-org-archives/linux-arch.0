From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv1 000/211] unicore32 architecture support
Date: Fri, 10 Dec 2010 13:35:24 +0100
Message-ID: <201012101335.24983.arnd@arndb.de>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn> <026901cb9848$17e71ac0$47b55040$@mprc.pku.edu.cn> <alpine.LFD.2.00.1012101156230.2653@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab0LJMff (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2010 07:35:35 -0500
In-Reply-To: <alpine.LFD.2.00.1012101156230.2653@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, 'Tejun Heo' <tj@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 10 December 2010, Thomas Gleixner wrote:
> And please mail them to yourself before you post them and make sure
> they apply and resemble exaclty what you wanted to send. I just
> noticed, that your mailer line-wrapped the patches:
> 
> +       /*
> +        * actually the registers should be pushed and pop'd conditionally,
> but
> +        * after bl the flags are certainly clobbered
> +        */
> 

Note that this and the threading automatically get handled by
'git send-email', there is probably not much point in trying
to make the currently used email program do the right thing.

Feel free to send the patches to me in private first to make
sure that the formalities of patch submission are right, then
send them to the mailing list again for discussion.

	Arnd
