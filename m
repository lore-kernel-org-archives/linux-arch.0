From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Date: Mon, 25 Aug 2014 19:16:00 +0200
Message-ID: <20140825171600.GH25892@linux-mips.org>
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Steven Hill <Steven.Hill@imgtec.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:

> this series adds mapping color control to the generic kmap code, allowing
> architectures with aliasing VIPT cache to use high memory. There's also
> use example of this new interface by xtensa.

I haven't actually ported this to MIPS but it certainly appears to be
the right framework to get highmem aliases handled on MIPS, too.

Though I still consider increasing PAGE_SIZE to 16k the preferable
solution because it will entirly do away with cache aliases.

Thanks,

  Ralf

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
