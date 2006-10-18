Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:9440 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422637AbWJRQS3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Oct 2006 12:18:29 -0400
Date: Wed, 18 Oct 2006 18:15:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0610181814100.31301@yvahk01.tjqt.qr>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
 <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


>> +#define lock_super(x) do {		\
>> +	struct super_block *sb = x;	\
>> +	get_fs_excl();			\
>> +	mutex_lock(&sb->s_lock);	\
>> +} while(0)
>
>Don't do this. The "x" passed in may be "sb", and then you end up with 
>bogus code.

So how about:

static inline void lock_super(struct super_block *sb)
{
	get_fs_excl();
	mutex_lock(&sb->s_lock);
	return;
}

which avoids any naming issue.


	-`J'
-- 
