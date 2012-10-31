From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 37/40] metag: Various sysfs drivers
Date: Wed, 31 Oct 2012 12:30:37 -0700
Message-ID: <20121031193037.GA2109@kroah.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
 <1351700061-7203-38-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41517 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760089Ab2JaTal (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2012 15:30:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1186037pad.19
        for <linux-arch@vger.kernel.org>; Wed, 31 Oct 2012 12:30:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351700061-7203-38-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wed, Oct 31, 2012 at 04:14:18PM +0000, James Hogan wrote:
> Add various Meta specific sysfs drivers.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

As you are creating new sysfs files, please also create new
Documentation/ABI/ files describing what those sysfs files do at the
same time.

thanks,

greg k-h
