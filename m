From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 40/40] fs: dafs: Add DAFS filesystem for metag
Date: Wed, 31 Oct 2012 19:39:25 +0000
Message-ID: <50917E6D.1050901@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-41-git-send-email-james.hogan@imgtec.com> <20121031164238.GJ2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20121031164238.GJ2616@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 31/10/12 16:42, Al Viro wrote:
> On Wed, Oct 31, 2012 at 04:14:21PM +0000, James Hogan wrote:
>> +static int fserrno;
> 
> ... and nothing visible serializing its users.  AFAICS, there's nothing
> stopping one thread from doing this fscall thing, then deciding to check
> what's in fserrno only to find that *another* thread has also done
> fscall - a different one, with different results and different value
> stored in fserrno.

Yep, I'll fix that.

Thanks for taking a look

James

