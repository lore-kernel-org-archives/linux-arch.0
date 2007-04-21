Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37072 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbXDUUyl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Apr 2007 16:54:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: larger per cpu data
References: <200704201246.17531.ak@suse.de>
	<m1fy6tiiiu.fsf@ebiederm.dsl.xmission.com>
	<200704212246.23397.ak@suse.de>
Date: Sat, 21 Apr 2007 14:53:57 -0600
In-Reply-To: <200704212246.23397.ak@suse.de> (Andi Kleen's message of "Sat, 21
	Apr 2007 22:46:23 +0200")
Message-ID: <m1bqhhih3u.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> writes:

> Just the internal implementation of the statistics. Not very many changes
> outside those include files

Ok. I guess I'm dense at the moment.  Which include files?

The only statistics I can think of at the moment are per network device,
and that doesn't sound like something that should be made per cpu.

Eric
