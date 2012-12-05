From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 12/44] metag: TBX source
Date: Wed, 05 Dec 2012 10:53:27 -0800
Message-ID: <1354733607.8320.3.camel@joe-AO722>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
	 <1354723742-6195-13-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354723742-6195-13-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, 2012-12-05 at 16:08 +0000, James Hogan wrote:
> Add source files from the Thread Binary Interface (TBI) library which
> provides useful low level operations and traps/context management.
[]
>  arch/metag/tbx/tbicache.c  |  462 ++++++++++++++++++++++++++++++++++++++++++++

Could you please run checkpatch on this file?
