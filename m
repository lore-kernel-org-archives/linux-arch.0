Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:39498 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfDITLu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Apr 2019 15:11:50 -0400
Message-ID: <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
Subject: Re: CONFIG_* symbols in UAPI headers?
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 09 Apr 2019 21:11:44 +0200
In-Reply-To: <20190408124640.GA607@lst.de>
References: <20190408124640.GA607@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190409191144.OOcaGyW3LyBqR84ZuI9HTB4hlGt0XTqgybtyAJR5o_c@z>

Christoph Hellwig schreef op ma 08-04-2019 om 14:46 [+0200]:
> There are a few similar issues, like struct elf_prstatus having
> a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

I've had the patch pasted below in a local branch for over five years, but
never dared to push it upstream.

Does it still apply?

Thanks,


Paul Bolle 

-- >8 ---
