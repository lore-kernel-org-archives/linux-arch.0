From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/1] metag: avoid unnecessary builtin dtb rebuilds
Date: Wed, 17 Apr 2013 09:37:58 -0600
Message-ID: <516EC1D6.6010205@wwwdotorg.org>
References: <1366192975-14953-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1366192975-14953-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On 04/17/2013 04:02 AM, James Hogan wrote:
> The builtin .dtb.S intermediate file needs to be marked with .SECONDARY
> so that it isn't automatically deleted (which causes it to be
> regenerated on every build). Also add *.dtb.S to clean-files so it gets
> cleaned up by make clean.
> 
> Similarly, if the specified builtin dtb isn't already in dtb-y (e.g.
> imported into the tree and specified in CONFIG_METAG_BUILTIN_DTB_NAME)
> it too will be treated as an intermediate and deleted automatically
> (again causing it to be regenerated on every build), so add it to dtb-y
> so it gets added to targets and the dtbs target.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
