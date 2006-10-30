Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:41525 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965161AbWJ3Qrr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Oct 2006 11:47:47 -0500
Subject: Re: [PATCH 2/7] severing fs.h, radix-tree.h -> sched.h
References: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 30 Oct 2006 08:47:44 -0800
In-Reply-To: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk> (Al Viro's message of "Mon, 30 Oct 2006 10:45:43 +0000")
Message-ID: <adak62hyclr.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

Trivial comment:

 >  /*
 > + * Superblock locking.  We really ought to get rid of these two.
 > + */
 > +void lock_super(struct super_block * sb)
 > +{
 > +	get_fs_excl();
 > +	mutex_lock(&sb->s_lock);
 > +}
 > +
 > +void unlock_super(struct super_block * sb)
 > +{
 > +	put_fs_excl();
 > +	mutex_unlock(&sb->s_lock);
 > +}
 > +
 > +EXPORT_SYMBOL(lock_super);
 > +EXPORT_SYMBOL(unlock_super);

isn't the current fashion to do this like:

void lock_super(struct super_block * sb)
{
	get_fs_excl();
	mutex_lock(&sb->s_lock);
}
EXPORT_SYMBOL(lock_super);

void unlock_super(struct super_block * sb)
{
	put_fs_excl();
	mutex_unlock(&sb->s_lock);
}
EXPORT_SYMBOL(unlock_super);
