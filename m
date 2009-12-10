From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 2/5] parisc: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 16:54:42 -0500
Message-ID: <20091210215442.GB28962@bombadil.infradead.org>
References: <4B212EEC.3060808@caviumnetworks.com> <1260466101-17545-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260466101-17545-2-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-parisc-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 10, 2009 at 09:28:18AM -0800, David Daney wrote:
> Use the new unreachable() macro instead of for(;;);
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Kyle McMartin <kyle@mcmartin.ca>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-parisc@vger.kernel.org
> ---

Thanks David, I'll bash this into my tree now that the macro is
upstream.

regards, Kyle
