From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 37/40] metag: Various sysfs drivers
Date: Fri, 9 Nov 2012 14:32:22 +0000
Message-ID: <201211091432.22638.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <20121031193037.GA2109@kroah.com> <50917ECF.7060103@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54803 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab2KIOcZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:32:25 -0500
In-Reply-To: <50917ECF.7060103@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:
> 
> On 31/10/12 19:30, Greg KH wrote:
> > On Wed, Oct 31, 2012 at 04:14:18PM +0000, James Hogan wrote:
> >> Add various Meta specific sysfs drivers.
> >>
> >> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > 
> > As you are creating new sysfs files, please also create new
> > Documentation/ABI/ files describing what those sysfs files do at the
> > same time.
> 
> Good point, I'll make sure Documentation is added.
> 

While I haven't looked at the contents of these files in much detail,
I suspect that they are not actually sysfs material at all. Anything
related to performance counters should probably go into "perf".

You can also have your own debugfs directories if that is not a good
fit, but when these are mainly debugging helps, debugfs seems more
appropriate than sysfs.

	Arnd
