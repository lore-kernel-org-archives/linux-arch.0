Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:26271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261496AbUCXUXU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 15:23:20 -0500
Date: Wed, 24 Mar 2004 12:23:17 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [CFT] compat_sys_mount
Message-Id: <20040324122317.184e127d.davem@redhat.com>
In-Reply-To: <20040324154832.GJ25059@parcelfarce.linux.theplanet.co.uk>
References: <20040324154832.GJ25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Looks fine to me.

You should be able to just "sed 's/sys32_mount/compat_sys_mount/'" in the
arch subdirs to hooks this up.
