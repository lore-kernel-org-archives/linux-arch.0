Return-Path: <jgarzik@pobox.com>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62410 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265651AbUEZQRM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2004 12:17:12 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BT15b-0004ni-TV
	for linux-arch@vger.kernel.org; Wed, 26 May 2004 17:17:12 +0100
Message-ID: <40B4C2FB.5040101@pobox.com>
Date: Wed, 26 May 2004 12:16:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: arch-specific "make" target
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


I just wanted to confirm that all architectures generate a bootable 
kernel image -- not just vmlinux -- then the developer types "make" with 
no arguments.

This is the 2.6 kernel standard, but I just got word that some arches 
don't follow this rule yet...

	Jeff
